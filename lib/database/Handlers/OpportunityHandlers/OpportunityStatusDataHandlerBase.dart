
 class OpportunityStatusDataHandlerBase {

  //   public static List<OpportunityStatus> GetOpportunityStatusRecordsPaged(DatabaseHandler databaseHandler, Context context, String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) {
  //       List<OpportunityStatus> dataList = new ArrayList<OpportunityStatus>();
  //       try {
  //           int startRowIndex = ((pageIndex - 1) * pageSize);

  //           String selectQuery = "SELECT A.* ";
  //           selectQuery += " FROM " + Tables.TABLE_OPPORTUNITYSTATUS + " A ";
  //           selectQuery += " WHERE A." + Columns.KEY_OWNERUSERID + " = " + Globals.AppUserID;
  //           selectQuery += " AND A." + Columns.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID + " = " + Globals.AppUserGroupID;
  //           selectQuery += " AND LOWER(IFNULL(A." + Columns.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + Columns.KEY_OPPORTUNITYSTATUS_ISDELETED + ",'false')) = 'false' ";
  //           selectQuery += " AND LOWER(IFNULL(A." + Columns.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + Columns.KEY_OPPORTUNITYSTATUS_ISACTIVE + ",'true')) = 'true' ";
  //           if (searchString.trim().length() > 0)
  //               selectQuery += " AND A." + Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME + " LIKE '%" + searchString + "%'";

  //           /* FILTER */
	// 		/*String groups = "";
	// 		String tags = "";
	// 		String groupitem = "";
	// 		for (Map.Entry<String, String> entry : filterHashMap.entrySet()) {
	// 			String key1 = entry.getKey();
	// 			String value1 = entry.getValue();
	// 			if (entry.getKey().equals("XXXXX")) {
	// 				groupitem = value1;
	// 			} else {
	// 				groups += (groups.equals("") ? "'" + key1 + "'" : ",'" + key1 + "'");
	// 				tags += (tags.equals("") ? value1 : "," + value1);
	// 			}
	// 		}
	// 		if (groupitem.trim().length() > 0)
	// 			selectQuery += " AND A." + Columns.KEY_OpportunityStatus_Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME + " IN(" + groupitem.trim() + ")";
	// 		if (groups.trim().length() > 0)
	// 			selectQuery += " AND TG." + Columns.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
	// 		if (tags.trim().length() > 0)
	// 			selectQuery += " AND T." + Columns.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

  //           selectQuery += " ORDER BY A." + sortColumn + " COLLATE NOCASE " + sortDirection;
  //           selectQuery += " LIMIT " + startRowIndex + "," + pageSize;


  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           Cursor cursor = db.rawQuery(selectQuery, null);
  //           if (cursor.moveToFirst()) {
  //               do {
  //                   OpportunityStatus dataItem = new OpportunityStatus();
  //                   dataItem.setOpportunityStatusID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID)));
  //                   dataItem.setOpportunityStatusCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSCODE)));
  //                   dataItem.setOpportunityStatusName(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME)));
  //                   dataItem.setSequentialOrder(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER)));
  //                   dataItem.setProbability(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_PROBABILITY)));
  //                   dataItem.setIndicator(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_INDICATOR)));
  //                   dataItem.setInternalCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_INTERNALCODE)));
  //                   dataItem.setWorkflowStageID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_WORKFLOWSTAGEID)));
  //                   dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_CREATEDON)));
  //                   dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_CREATEDBY)));
  //                   dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_MODIFIEDON)));
  //                   dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_MODIFIEDBY)));
  //                   dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_ISACTIVE)));
  //                   dataItem.setUid(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_UID)));
  //                   dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_APPUSERID)));
  //                   dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID)));
  //                   dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_ISARCHIVED)));
  //                   dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_ISDELETED)));


  //                   dataItem.setId(cursor.getString(cursor.getColumnIndex(Columns.KEY_ID)));
  //                   dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(Columns.KEY_ISDIRTY)));
  //                   dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(Columns.KEY_ISDELETED)));
  //                   dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(Columns.KEY_UPSYNCMESSAGE)));
  //                   dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(Columns.KEY_DOWNSYNCMESSAGE)));
  //                   dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_SCREATEDON)));
  //                   dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_SMODIFIEDON)));
  //                   dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(Columns.KEY_CREATEDBYUSER)));
  //                   dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(Columns.KEY_MODIFIEDBYUSER)));
  //                   dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OWNERUSERID)));

  //                   dataList.add(dataItem);
  //               } while (cursor.moveToNext());
  //           }
  //           cursor.close();
  //           //db.close();
  //       } catch (Exception ex) {
  //           Globals.HandleException(context, "OpportunityStatusDataHandlerBase:GetOpportunityStatusRecordsPaged()", ex);
  //           throw ex;
  //       }
  //       return dataList;
  //   }

  //   public static List<OpportunityStatus> GetOpportunityStatusRecords(DatabaseHandler databaseHandler, Context context, String searchString) {
  //       List<OpportunityStatus> dataList = new ArrayList<OpportunityStatus>();
  //       try {
  //           String selectQuery = "SELECT A.* ";
  //           selectQuery += " FROM " + Tables.TABLE_OPPORTUNITYSTATUS + " A ";
  //           selectQuery += " WHERE A." + Columns.KEY_OWNERUSERID + " = " + Globals.AppUserID;
  //           selectQuery += " AND A." + Columns.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID + " = " + Globals.AppUserGroupID;
  //           selectQuery += " AND LOWER(IFNULL(A." + Columns.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + Columns.KEY_OPPORTUNITYSTATUS_ISDELETED + ",'false')) = 'false' ";
  //           selectQuery += " AND LOWER(IFNULL(A." + Columns.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + Columns.KEY_OPPORTUNITYSTATUS_ISACTIVE + ",'true')) = 'true' ";
  //           if (searchString.trim().length() > 0)
  //               selectQuery += " AND A." + Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME + " LIKE '" + searchString + "%'";
  //           selectQuery += " ORDER BY COALESCE(A." + Columns.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER + ",1)";

  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           Cursor cursor = db.rawQuery(selectQuery, null);
  //           if (cursor.moveToFirst()) {
  //               do {
  //                   OpportunityStatus dataItem = new OpportunityStatus();
  //                   dataItem.setOpportunityStatusID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID)));
  //                   dataItem.setOpportunityStatusCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSCODE)));
  //                   dataItem.setOpportunityStatusName(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME)));
  //                   dataItem.setSequentialOrder(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER)));
  //                   dataItem.setProbability(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_PROBABILITY)));
  //                   dataItem.setIndicator(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_INDICATOR)));
  //                   dataItem.setInternalCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_INTERNALCODE)));
  //                   dataItem.setWorkflowStageID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_WORKFLOWSTAGEID)));
  //                   dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_CREATEDON)));
  //                   dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_CREATEDBY)));
  //                   dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_MODIFIEDON)));
  //                   dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_MODIFIEDBY)));
  //                   dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_ISACTIVE)));
  //                   dataItem.setUid(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_UID)));
  //                   dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_APPUSERID)));
  //                   dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID)));
  //                   dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_ISARCHIVED)));
  //                   dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_ISDELETED)));


  //                   dataItem.setId(cursor.getString(cursor.getColumnIndex(Columns.KEY_ID)));
  //                   dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(Columns.KEY_ISDIRTY)));
  //                   dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(Columns.KEY_ISDELETED)));
  //                   dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(Columns.KEY_UPSYNCMESSAGE)));
  //                   dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(Columns.KEY_DOWNSYNCMESSAGE)));
  //                   dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_SCREATEDON)));
  //                   dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_SMODIFIEDON)));
  //                   dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(Columns.KEY_CREATEDBYUSER)));
  //                   dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(Columns.KEY_MODIFIEDBYUSER)));
  //                   dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OWNERUSERID)));

  //                   dataList.add(dataItem);
  //               } while (cursor.moveToNext());
  //           }
  //           cursor.close();
  //           //db.close();
  //       } catch (Exception ex) {
  //           Globals.HandleException(context, "OpportunityStatusDataHandlerBase:GetOpportunityStatusRecords()", ex);
  //           throw ex;
  //       }
  //       return dataList;
  //   }

  //   public static OpportunityStatus GetOpportunityStatusRecord(DatabaseHandler databaseHandler, Context context, String id) {
  //       OpportunityStatus dataItem = null;
  //       try {
  //           id = Globals.TryParseLongForDBId(id);

  //           String selectQuery = "SELECT A.* ";
  //           selectQuery += " FROM " + Tables.TABLE_OPPORTUNITYSTATUS + " A ";
  //           selectQuery += " WHERE A." + Columns.KEY_ID + " = " + id;
  //           selectQuery += " AND A." + Columns.KEY_OWNERUSERID + " = " + Globals.AppUserID;
  //           selectQuery += " AND A." + Columns.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           Cursor cursor = db.rawQuery(selectQuery, null);
  //           if (cursor.moveToFirst()) {
  //               do {
  //                   dataItem = new OpportunityStatus();
  //                   dataItem.setOpportunityStatusID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID)));
  //                   dataItem.setOpportunityStatusCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSCODE)));
  //                   dataItem.setOpportunityStatusName(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME)));
  //                   dataItem.setSequentialOrder(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER)));
  //                   dataItem.setProbability(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_PROBABILITY)));
  //                   dataItem.setIndicator(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_INDICATOR)));
  //                   dataItem.setInternalCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_INTERNALCODE)));
  //                   dataItem.setWorkflowStageID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_WORKFLOWSTAGEID)));
  //                   dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_CREATEDON)));
  //                   dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_CREATEDBY)));
  //                   dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_MODIFIEDON)));
  //                   dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_MODIFIEDBY)));
  //                   dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_ISACTIVE)));
  //                   dataItem.setUid(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_UID)));
  //                   dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_APPUSERID)));
  //                   dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID)));
  //                   dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_ISARCHIVED)));
  //                   dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_ISDELETED)));


  //                   dataItem.setId(cursor.getString(cursor.getColumnIndex(Columns.KEY_ID)));
  //                   dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(Columns.KEY_ISDIRTY)));
  //                   dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(Columns.KEY_ISDELETED)));
  //                   dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(Columns.KEY_UPSYNCMESSAGE)));
  //                   dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(Columns.KEY_DOWNSYNCMESSAGE)));
  //                   dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_SCREATEDON)));
  //                   dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_SMODIFIEDON)));
  //                   dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(Columns.KEY_CREATEDBYUSER)));
  //                   dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(Columns.KEY_MODIFIEDBYUSER)));
  //                   dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OWNERUSERID)));

  //               } while (cursor.moveToNext());
  //           }
  //           cursor.close();
  //           //db.close();
  //       } catch (Exception ex) {
  //           Globals.HandleException(context, "OpportunityStatusDataHandlerBase:GetOpportunityStatusRecord()", ex);
  //           throw ex;
  //       }
  //       return dataItem;
  //   }

  //   public static OpportunityStatus GetMasterOpportunityStatusRecord(DatabaseHandler databaseHandler, Context context, String id) {
  //       OpportunityStatus dataItem = null;
  //       try {
  //           id = Globals.TryParseLongForDBId(id);

  //           String selectQuery = "SELECT A.* ";
  //           selectQuery += " FROM " + Tables.TABLE_OPPORTUNITYSTATUS + " A ";
  //           selectQuery += " WHERE A." + Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID + " = " + id;
  //           selectQuery += " AND A." + Columns.KEY_OWNERUSERID + " = " + Globals.AppUserID;
  //           selectQuery += " AND A." + Columns.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           Cursor cursor = db.rawQuery(selectQuery, null);
  //           if (cursor.moveToFirst()) {
  //               do {
  //                   dataItem = new OpportunityStatus();
  //                   dataItem.setOpportunityStatusID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID)));
  //                   dataItem.setOpportunityStatusCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSCODE)));
  //                   dataItem.setOpportunityStatusName(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME)));
  //                   dataItem.setSequentialOrder(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER)));
  //                   dataItem.setProbability(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_PROBABILITY)));
  //                   dataItem.setIndicator(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_INDICATOR)));
  //                   dataItem.setInternalCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_INTERNALCODE)));
  //                   dataItem.setWorkflowStageID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_WORKFLOWSTAGEID)));
  //                   dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_CREATEDON)));
  //                   dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_CREATEDBY)));
  //                   dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_MODIFIEDON)));
  //                   dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_MODIFIEDBY)));
  //                   dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_ISACTIVE)));
  //                   dataItem.setUid(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_UID)));
  //                   dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_APPUSERID)));
  //                   dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID)));
  //                   dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_ISARCHIVED)));
  //                   dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_ISDELETED)));


  //                   dataItem.setId(cursor.getString(cursor.getColumnIndex(Columns.KEY_ID)));
  //                   dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(Columns.KEY_ISDIRTY)));
  //                   dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(Columns.KEY_ISDELETED)));
  //                   dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(Columns.KEY_UPSYNCMESSAGE)));
  //                   dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(Columns.KEY_DOWNSYNCMESSAGE)));
  //                   dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_SCREATEDON)));
  //                   dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_SMODIFIEDON)));
  //                   dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(Columns.KEY_CREATEDBYUSER)));
  //                   dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(Columns.KEY_MODIFIEDBYUSER)));
  //                   dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OWNERUSERID)));

  //               } while (cursor.moveToNext());
  //           }
  //           cursor.close();
  //           //db.close();
  //       } catch (Exception ex) {
  //           Globals.HandleException(context, "OpportunityStatusDataHandlerBase:GetMasterOpportunityStatusRecord()", ex);
  //           throw ex;
  //       }
  //       return dataItem;
  //   }

  //   public static long AddOpportunityStatusRecord(DatabaseHandler databaseHandler, Context context, OpportunityStatus dataItem) {
  //       long id = 0;
  //       try {
  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           ContentValues values = new ContentValues();
  //           if (dataItem.getOpportunityStatusID() != null && !dataItem.getOpportunityStatusID().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID, dataItem.getOpportunityStatusID());
  //           if (dataItem.getOpportunityStatusCode() != null && !dataItem.getOpportunityStatusCode().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSCODE, dataItem.getOpportunityStatusCode());
  //           if (dataItem.getOpportunityStatusName() != null && !dataItem.getOpportunityStatusName().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME, dataItem.getOpportunityStatusName());
  //           if (dataItem.getSequentialOrder() != null && !dataItem.getSequentialOrder().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER, dataItem.getSequentialOrder());
  //           if (dataItem.getProbability() != null && !dataItem.getProbability().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_PROBABILITY, dataItem.getProbability());
  //           if (dataItem.getIndicator() != null && !dataItem.getIndicator().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_INDICATOR, dataItem.getIndicator());
  //           if (dataItem.getInternalCode() != null && !dataItem.getInternalCode().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_INTERNALCODE, dataItem.getInternalCode());
  //           if (dataItem.getWorkflowStageID() != null && !dataItem.getWorkflowStageID().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_WORKFLOWSTAGEID, dataItem.getWorkflowStageID());
  //           if (dataItem.getCreatedOn() != null && !dataItem.getCreatedOn().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_CREATEDON, dataItem.getCreatedOn());
  //           if (dataItem.getCreatedBy() != null && !dataItem.getCreatedBy().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_CREATEDBY, dataItem.getCreatedBy());
  //           if (dataItem.getModifiedOn() != null && !dataItem.getModifiedOn().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_MODIFIEDON, dataItem.getModifiedOn());
  //           if (dataItem.getModifiedBy() != null && !dataItem.getModifiedBy().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_MODIFIEDBY, dataItem.getModifiedBy());
  //           if (dataItem.getIsActive() != null && !dataItem.getIsActive().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_ISACTIVE, dataItem.getIsActive());
  //           if (dataItem.getUid() != null && !dataItem.getUid().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_UID, dataItem.getUid());
  //           if (dataItem.getAppUserID() != null && !dataItem.getAppUserID().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_APPUSERID, dataItem.getAppUserID());
  //           if (dataItem.getAppUserGroupID() != null && !dataItem.getAppUserGroupID().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID, dataItem.getAppUserGroupID());
  //           if (dataItem.getIsArchived() != null && !dataItem.getIsArchived().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_ISARCHIVED, dataItem.getIsArchived());
  //           if (dataItem.getIsDeleted() != null && !dataItem.getIsDeleted().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_ISDELETED, dataItem.getIsDeleted());
  //           if (dataItem.getId() != null && !dataItem.getId().equals("null"))
  //               values.put(Columns.KEY_ID, dataItem.getId());
  //           if (dataItem.getIsDirty() != null && !dataItem.getIsDirty().equals("null"))
  //               values.put(Columns.KEY_ISDIRTY, dataItem.getIsDirty());
  //           if (dataItem.getIsDeleted1() != null && !dataItem.getIsDeleted1().equals("null"))
  //               values.put(Columns.KEY_ISDELETED, dataItem.getIsDeleted1());
  //           if (dataItem.getUpSyncMessage() != null && !dataItem.getUpSyncMessage().equals("null"))
  //               values.put(Columns.KEY_UPSYNCMESSAGE, dataItem.getUpSyncMessage());
  //           if (dataItem.getDownSyncMessage() != null && !dataItem.getDownSyncMessage().equals("null"))
  //               values.put(Columns.KEY_DOWNSYNCMESSAGE, dataItem.getDownSyncMessage());
  //           if (dataItem.getSCreatedOn() != null && !dataItem.getSCreatedOn().equals("null"))
  //               values.put(Columns.KEY_SCREATEDON, dataItem.getSCreatedOn());
  //           if (dataItem.getSModifiedOn() != null && !dataItem.getSModifiedOn().equals("null"))
  //               values.put(Columns.KEY_SMODIFIEDON, dataItem.getSModifiedOn());
  //           if (dataItem.getCreatedByUser() != null && !dataItem.getCreatedByUser().equals("null"))
  //               values.put(Columns.KEY_CREATEDBYUSER, dataItem.getCreatedByUser());
  //           if (dataItem.getModifiedByUser() != null && !dataItem.getModifiedByUser().equals("null"))
  //               values.put(Columns.KEY_MODIFIEDBYUSER, dataItem.getModifiedByUser());
  //           if (dataItem.getOwnerUserID() != null && !dataItem.getOwnerUserID().equals("null"))
  //               values.put(Columns.KEY_OWNERUSERID, dataItem.getOwnerUserID());
  //           values.put(Columns.KEY_UPSYNCINDEX, 0);
  //           values.put(Columns.KEY_ISACTIVE, "true");
  //           values.put(Columns.KEY_ISDELETED, "false");

  //           id = db.insert(Tables.TABLE_OPPORTUNITYSTATUS, null, values);
  //           //db.close();
  //       } catch (Exception ex) {
  //           Globals.HandleException(context, "DatabaseHandler:AddOpportunityStatusRecord()", ex);
  //           throw ex;
  //       }
  //       return id;
  //   }

  //   public static long UpdateOpportunityStatusRecord(DatabaseHandler databaseHandler, Context context, String id1, OpportunityStatus dataItem) {
  //       long id = 0;
  //       try {
  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           ContentValues values = new ContentValues();
  //           if (dataItem.getOpportunityStatusID() != null && !dataItem.getOpportunityStatusID().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID, dataItem.getOpportunityStatusID());
  //           if (dataItem.getOpportunityStatusCode() != null && !dataItem.getOpportunityStatusCode().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSCODE, dataItem.getOpportunityStatusCode());
  //           if (dataItem.getOpportunityStatusName() != null && !dataItem.getOpportunityStatusName().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME, dataItem.getOpportunityStatusName());
  //           if (dataItem.getSequentialOrder() != null && !dataItem.getSequentialOrder().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER, dataItem.getSequentialOrder());
  //           if (dataItem.getProbability() != null && !dataItem.getProbability().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_PROBABILITY, dataItem.getProbability());
  //           if (dataItem.getIndicator() != null && !dataItem.getIndicator().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_INDICATOR, dataItem.getIndicator());
  //           if (dataItem.getInternalCode() != null && !dataItem.getInternalCode().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_INTERNALCODE, dataItem.getInternalCode());
  //           if (dataItem.getWorkflowStageID() != null && !dataItem.getWorkflowStageID().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_WORKFLOWSTAGEID, dataItem.getWorkflowStageID());
  //           if (dataItem.getCreatedOn() != null && !dataItem.getCreatedOn().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_CREATEDON, dataItem.getCreatedOn());
  //           if (dataItem.getCreatedBy() != null && !dataItem.getCreatedBy().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_CREATEDBY, dataItem.getCreatedBy());
  //           if (dataItem.getModifiedOn() != null && !dataItem.getModifiedOn().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_MODIFIEDON, dataItem.getModifiedOn());
  //           if (dataItem.getModifiedBy() != null && !dataItem.getModifiedBy().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_MODIFIEDBY, dataItem.getModifiedBy());
  //           if (dataItem.getIsActive() != null && !dataItem.getIsActive().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_ISACTIVE, dataItem.getIsActive());
  //           if (dataItem.getUid() != null && !dataItem.getUid().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_UID, dataItem.getUid());
  //           if (dataItem.getAppUserID() != null && !dataItem.getAppUserID().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_APPUSERID, dataItem.getAppUserID());
  //           if (dataItem.getAppUserGroupID() != null && !dataItem.getAppUserGroupID().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID, dataItem.getAppUserGroupID());
  //           if (dataItem.getIsArchived() != null && !dataItem.getIsArchived().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_ISARCHIVED, dataItem.getIsArchived());
  //           if (dataItem.getIsDeleted() != null && !dataItem.getIsDeleted().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYSTATUS_ISDELETED, dataItem.getIsDeleted());
  //           if (dataItem.getId() != null && !dataItem.getId().equals("null"))
  //               values.put(Columns.KEY_ID, dataItem.getId());
  //           if (dataItem.getIsDirty() != null && !dataItem.getIsDirty().equals("null"))
  //               values.put(Columns.KEY_ISDIRTY, dataItem.getIsDirty());
  //           if (dataItem.getIsDeleted1() != null && !dataItem.getIsDeleted1().equals("null"))
  //               values.put(Columns.KEY_ISDELETED, dataItem.getIsDeleted1());
  //           if (dataItem.getUpSyncMessage() != null && !dataItem.getUpSyncMessage().equals("null"))
  //               values.put(Columns.KEY_UPSYNCMESSAGE, dataItem.getUpSyncMessage());
  //           if (dataItem.getDownSyncMessage() != null && !dataItem.getDownSyncMessage().equals("null"))
  //               values.put(Columns.KEY_DOWNSYNCMESSAGE, dataItem.getDownSyncMessage());
  //           if (dataItem.getSCreatedOn() != null && !dataItem.getSCreatedOn().equals("null"))
  //               values.put(Columns.KEY_SCREATEDON, dataItem.getSCreatedOn());
  //           if (dataItem.getSModifiedOn() != null && !dataItem.getSModifiedOn().equals("null"))
  //               values.put(Columns.KEY_SMODIFIEDON, dataItem.getSModifiedOn());
  //           if (dataItem.getCreatedByUser() != null && !dataItem.getCreatedByUser().equals("null"))
  //               values.put(Columns.KEY_CREATEDBYUSER, dataItem.getCreatedByUser());
  //           if (dataItem.getModifiedByUser() != null && !dataItem.getModifiedByUser().equals("null"))
  //               values.put(Columns.KEY_MODIFIEDBYUSER, dataItem.getModifiedByUser());
  //           if (dataItem.getOwnerUserID() != null && !dataItem.getOwnerUserID().equals("null"))
  //               values.put(Columns.KEY_OWNERUSERID, dataItem.getOwnerUserID());
  //           if (dataItem.getUpSyncIndex() != null && !dataItem.getUpSyncIndex().equals("null"))
  //               values.put(Columns.KEY_UPSYNCINDEX, dataItem.getUpSyncIndex());

  //           id = db.update(Tables.TABLE_OPPORTUNITYSTATUS, values, Columns.KEY_ID + " = " + id1, null);
  //           //db.close();
  //       } catch (Exception ex) {
  //           Globals.HandleException(context, "DatabaseHandler:UpdateOpportunityStatusRecord()", ex);
  //           throw ex;
  //       }
  //       return id;
  //   }

  //   public static long DeleteOpportunityStatusRecord(DatabaseHandler databaseHandler, Context context, String id1) {
  //       long id = 0;
  //       try {
  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           id = db.delete(Tables.TABLE_OPPORTUNITYSTATUS, Columns.KEY_ID + " = " + id1, null);
  //           //db.close();
  //       } catch (Exception ex) {
  //           Globals.HandleException(context, "DatabaseHandler:DeleteOpportunityStatusRecord()", ex);
  //           throw ex;
  //       }
  //       return id;
  //   }

  //   public static String GetServerId(DatabaseHandler databaseHandler, Context context, String id) {
  //       String serverId = "-1";
  //       try {
  //           id = Globals.TryParseLongForDBId(id);

  //           String selectQuery = "SELECT A." + Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID;
  //           selectQuery += " FROM " + Tables.TABLE_OPPORTUNITYSTATUS + " A ";
  //           selectQuery += " WHERE A." + Columns.KEY_ID + " = " + id;

  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           Cursor cursor = db.rawQuery(selectQuery, null);
  //           if (cursor.moveToFirst()) {
  //               serverId = cursor.getString(0);
  //           }
  //           cursor.close();
  //           //db.close();
  //       } catch (Exception ex) {
  //           Globals.HandleException(context, "OpportunityStatusDataHandlerBase:GetServerId()", ex);
  //           throw ex;
  //       }
  //       return serverId;
  //   }

  //   public static String GetLocalId(DatabaseHandler databaseHandler, Context context, String id) {
  //       String localId = "";
  //       try {

  //           id = Globals.TryParseLongForDBId(id);

  //           String selectQuery = "SELECT A." + Columns.KEY_ID;
  //           selectQuery += " FROM " + Tables.TABLE_OPPORTUNITYSTATUS + " A ";
  //           selectQuery += " WHERE A." + Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID + " = " + id;

  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           Cursor cursor = db.rawQuery(selectQuery, null);
  //           if (cursor.moveToFirst()) {
  //               localId = cursor.getString(0);
  //           }
  //           cursor.close();
  //           //db.close();
  //       } catch (Exception ex) {
  //           Globals.HandleException(context, "OpportunityStatusDataHandlerBase:GetLocalId()", ex);
  //           throw ex;
  //       }
  //       return localId;
  //   }

  //   public static List<OpportunityStatus> GetOpportunityStatusUpSyncRecords(DatabaseHandler databaseHandler, Context context, String changeType) {
  //       List<OpportunityStatus> dataList = new ArrayList<OpportunityStatus>();
  //       try {
  //           String selectQuery = "SELECT * FROM " + Tables.TABLE_OPPORTUNITYSTATUS + " WHERE " + Columns.KEY_ISDIRTY + " = 'true' AND " + Columns.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
  //           if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
  //               selectQuery = "SELECT * FROM " + Tables.TABLE_OPPORTUNITYSTATUS + " WHERE " + Columns.KEY_ISDIRTY + " = 'true' AND " + Columns.KEY_ISDELETED + " = 'false' " + " AND " + Columns.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
  //           } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
  //               selectQuery = "SELECT * FROM " + Tables.TABLE_OPPORTUNITYSTATUS + " WHERE " + Columns.KEY_ISDIRTY + " = 'true' AND " + Columns.KEY_ISDELETED + " = 'true' " + " AND " + Columns.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
  //           }
  //           selectQuery += " AND " + Columns.KEY_OWNERUSERID + " = " + Globals.AppUserID;
  //           selectQuery += " AND " + Columns.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           Cursor cursor = db.rawQuery(selectQuery, null);
  //           if (cursor.moveToFirst()) {
  //               do {
  //                   OpportunityStatus dataItem = new OpportunityStatus();
  //                   dataItem.setOpportunityStatusID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID)));
  //                   dataItem.setOpportunityStatusCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSCODE)));
  //                   dataItem.setOpportunityStatusName(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME)));
  //                   dataItem.setSequentialOrder(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER)));
  //                   dataItem.setProbability(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_PROBABILITY)));
  //                   dataItem.setIndicator(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_INDICATOR)));
  //                   dataItem.setInternalCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_INTERNALCODE)));
  //                   dataItem.setWorkflowStageID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_WORKFLOWSTAGEID)));
  //                   dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_CREATEDON)));
  //                   dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_CREATEDBY)));
  //                   dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_MODIFIEDON)));
  //                   dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_MODIFIEDBY)));
  //                   dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_ISACTIVE)));
  //                   dataItem.setUid(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_UID)));
  //                   dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_APPUSERID)));
  //                   dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID)));
  //                   dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_ISARCHIVED)));
  //                   dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_ISDELETED)));

  //                   dataItem.setId(cursor.getString(cursor.getColumnIndex(Columns.KEY_ID)));
  //                   dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(Columns.KEY_ISDIRTY)));
  //                   dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(Columns.KEY_ISDELETED)));
  //                   dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(Columns.KEY_UPSYNCMESSAGE)));
  //                   dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(Columns.KEY_DOWNSYNCMESSAGE)));
  //                   dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_SCREATEDON)));
  //                   dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_SMODIFIEDON)));
  //                   dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(Columns.KEY_CREATEDBYUSER)));
  //                   dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(Columns.KEY_MODIFIEDBYUSER)));
  //                   dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OWNERUSERID)));

  //                   dataList.add(dataItem);
  //               } while (cursor.moveToNext());
  //           }
  //           cursor.close();
  //           //db.close();
  //       } catch (Exception ex) {
  //           Globals.HandleException(context, "OpportunityStatusDataHandlerBase:GetOpportunityStatusUpSyncRecords()", ex);
  //           throw ex;
  //       }
  //       return dataList;
  //   }


	//  public static OpportunityStatus GetOpportunityStatusRecordByUid(DatabaseHandler databaseHandler, Context context, String uid) {
  //       OpportunityStatus dataItem = null;
  //       try
  //       {

	// 		String selectQuery = 	"SELECT A.* " ;
	// 	selectQuery += " FROM " + Tables.TABLE_OPPORTUNITYSTATUS + " A "; 
	// 		selectQuery += " WHERE A."  + Columns.KEY_OPPORTUNITYSTATUS_UID + " = '" + uid + "'";
	// 		//selectQuery += " AND A." + Columns.KEY_OWNERUSERID + " = " + Globals.AppUserID;
	// 		//selectQuery += " AND A." + Columns.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           Cursor cursor = db.rawQuery(selectQuery, null);
  //           if (cursor.moveToFirst()) {
  //               do {
  //                   dataItem = new OpportunityStatus();
	// 						dataItem.setOpportunityStatusID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID)));
	// 	dataItem.setOpportunityStatusCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSCODE)));
	// 	dataItem.setOpportunityStatusName(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME)));
	// 	dataItem.setSequentialOrder(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER)));
	// 	dataItem.setProbability(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_PROBABILITY)));
	// 	dataItem.setIndicator(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_INDICATOR)));
	// 	dataItem.setInternalCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_INTERNALCODE)));
	// 	dataItem.setWorkflowStageID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_WORKFLOWSTAGEID)));
	// 	dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_CREATEDON)));
	// 	dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_CREATEDBY)));
	// 	dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_MODIFIEDON)));
	// 	dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_MODIFIEDBY)));
	// 	dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_ISACTIVE)));
	// 	dataItem.setUid(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_UID)));
	// 	dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_APPUSERID)));
	// 	dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID)));
	// 	dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_ISARCHIVED)));
	// 	dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYSTATUS_ISDELETED)));


					
	// 				dataItem.setId(cursor.getString(cursor.getColumnIndex(Columns.KEY_ID)));
	// 				dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(Columns.KEY_ISDIRTY)));
	// 				dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(Columns.KEY_ISDELETED)));
	// 				dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(Columns.KEY_UPSYNCMESSAGE)));				
	// 				dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(Columns.KEY_DOWNSYNCMESSAGE)));
	// 				dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_SCREATEDON)));
	// 				dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_SMODIFIEDON)));
	// 				dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(Columns.KEY_CREATEDBYUSER)));
	// 				dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(Columns.KEY_MODIFIEDBYUSER)));
	// 				dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OWNERUSERID)));
					
	// 			} while (cursor.moveToNext());
  //           }
  //           cursor.close();
  //           //db.close();
  //       }
  //       catch(Exception ex)
  //       {
	//     Globals.HandleException(context, "OpportunityStatusDataHandlerBase:GetOpportunityStatusRecordByUid()", ex);
  //           throw ex;
  //       }
  //       return dataItem;
  //   }

	/*-------------------HAPPSALES-------------------*/

}