

 class OpportunityTypeDataHandlerBase {

  //   public static List<OpportunityType> GetOpportunityTypeRecordsPaged(DatabaseHandler databaseHandler, Context context, String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) {
  //       List<OpportunityType> dataList = new ArrayList<OpportunityType>();
  //       try {
  //           int startRowIndex = ((pageIndex - 1) * pageSize);

  //           String selectQuery = "SELECT A.* ";
  //           selectQuery += " FROM " + Tables.TABLE_OPPORTUNITYTYPE + " A ";
  //           selectQuery += " WHERE A." + Columns.KEY_OWNERUSERID + " = " + Globals.AppUserID;
  //           selectQuery += " AND A." + Columns.KEY_OPPORTUNITYTYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;
  //           selectQuery += " AND LOWER(IFNULL(A." + Columns.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + Columns.KEY_OPPORTUNITYTYPE_ISDELETED + ",'false')) = 'false' ";
  //           selectQuery += " AND LOWER(IFNULL(A." + Columns.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + Columns.KEY_OPPORTUNITYTYPE_ISACTIVE + ",'true')) = 'true' ";
  //           if (searchString.trim().length() > 0)
  //               selectQuery += " AND A." + Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME + " LIKE '%" + searchString.replace("'","''") + "%'";

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
	// 			selectQuery += " AND A." + Columns.KEY_OpportunityType_Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME + " IN(" + groupitem.trim() + ")";
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
  //                   OpportunityType dataItem = new OpportunityType();
  //                   dataItem.setOpportunityTypeID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPEID)));
  //                   dataItem.setOpportunityTypeCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPECODE)));
  //                   dataItem.setOpportunityTypeName(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME)));
  //                   dataItem.setInternalCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_INTERNALCODE)));
  //                   dataItem.setIsDefault(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISDEFAULT)));
  //                   dataItem.setSequentialOrder(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_SEQUENTIALORDER)));
  //                   dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_CREATEDON)));
  //                   dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_CREATEDBY)));
  //                   dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_MODIFIEDON)));
  //                   dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_MODIFIEDBY)));
  //                   dataItem.setUid(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_UID)));
  //                   dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_APPUSERID)));
  //                   dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_APPUSERGROUPID)));
  //                   dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISARCHIVED)));
  //                   dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISACTIVE)));
  //                   dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISDELETED)));


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
  //           Globals.HandleException(context, "OpportunityTypeDataHandlerBase:GetOpportunityTypeRecordsPaged()", ex);
  //           throw ex;
  //       }
  //       return dataList;
  //   }

  //   public static List<OpportunityType> GetOpportunityTypeRecords(DatabaseHandler databaseHandler, Context context, String searchString) {
  //       List<OpportunityType> dataList = new ArrayList<OpportunityType>();
  //       try {
  //           String selectQuery = "SELECT A.* ";
  //           selectQuery += " FROM " + Tables.TABLE_OPPORTUNITYTYPE + " A ";
  //           selectQuery += " WHERE A." + Columns.KEY_OWNERUSERID + " = " + Globals.AppUserID;
  //           selectQuery += " AND A." + Columns.KEY_OPPORTUNITYTYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;
  //           selectQuery += " AND LOWER(IFNULL(A." + Columns.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + Columns.KEY_OPPORTUNITYTYPE_ISDELETED + ",'false')) = 'false' ";
  //           selectQuery += " AND LOWER(IFNULL(A." + Columns.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + Columns.KEY_OPPORTUNITYTYPE_ISACTIVE + ",'true')) = 'true' ";
  //           if (searchString.trim().length() > 0)
  //               selectQuery += " AND A." + Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME + " LIKE '" + searchString.replace("'","''") + "%'";
  //           selectQuery += " ORDER BY A." + Columns.KEY_OPPORTUNITYTYPE_SEQUENTIALORDER;

  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           Cursor cursor = db.rawQuery(selectQuery, null);
  //           if (cursor.moveToFirst()) {
  //               do {
  //                   OpportunityType dataItem = new OpportunityType();
  //                   dataItem.setOpportunityTypeID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPEID)));
  //                   dataItem.setOpportunityTypeCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPECODE)));
  //                   dataItem.setOpportunityTypeName(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME)));
  //                   dataItem.setInternalCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_INTERNALCODE)));
  //                   dataItem.setIsDefault(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISDEFAULT)));
  //                   dataItem.setSequentialOrder(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_SEQUENTIALORDER)));
  //                   dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_CREATEDON)));
  //                   dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_CREATEDBY)));
  //                   dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_MODIFIEDON)));
  //                   dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_MODIFIEDBY)));
  //                   dataItem.setUid(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_UID)));
  //                   dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_APPUSERID)));
  //                   dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_APPUSERGROUPID)));
  //                   dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISARCHIVED)));
  //                   dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISACTIVE)));
  //                   dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISDELETED)));


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
  //           Globals.HandleException(context, "OpportunityTypeDataHandlerBase:GetOpportunityTypeRecords()", ex);
  //           throw ex;
  //       }
  //       return dataList;
  //   }

  //   public static OpportunityType GetOpportunityTypeRecord(DatabaseHandler databaseHandler, Context context, String id) {
  //       OpportunityType dataItem = null;
  //       try {
  //           id = Globals.TryParseLongForDBId(id);

  //           String selectQuery = "SELECT A.* ";
  //           selectQuery += " FROM " + Tables.TABLE_OPPORTUNITYTYPE + " A ";
  //           selectQuery += " WHERE A." + Columns.KEY_ID + " = " + id;
  //           selectQuery += " AND A." + Columns.KEY_OWNERUSERID + " = " + Globals.AppUserID;
  //           selectQuery += " AND A." + Columns.KEY_OPPORTUNITYTYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           Cursor cursor = db.rawQuery(selectQuery, null);
  //           if (cursor.moveToFirst()) {
  //               do {
  //                   dataItem = new OpportunityType();
  //                   dataItem.setOpportunityTypeID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPEID)));
  //                   dataItem.setOpportunityTypeCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPECODE)));
  //                   dataItem.setOpportunityTypeName(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME)));
  //                   dataItem.setInternalCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_INTERNALCODE)));
  //                   dataItem.setIsDefault(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISDEFAULT)));
  //                   dataItem.setSequentialOrder(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_SEQUENTIALORDER)));
  //                   dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_CREATEDON)));
  //                   dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_CREATEDBY)));
  //                   dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_MODIFIEDON)));
  //                   dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_MODIFIEDBY)));
  //                   dataItem.setUid(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_UID)));
  //                   dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_APPUSERID)));
  //                   dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_APPUSERGROUPID)));
  //                   dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISARCHIVED)));
  //                   dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISACTIVE)));
  //                   dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISDELETED)));


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
  //           Globals.HandleException(context, "OpportunityTypeDataHandlerBase:GetOpportunityTypeRecord()", ex);
  //           throw ex;
  //       }
  //       return dataItem;
  //   }

  //   public static OpportunityType GetMasterOpportunityTypeRecord(DatabaseHandler databaseHandler, Context context, String id) {
  //       OpportunityType dataItem = null;
  //       try {
  //           id = Globals.TryParseLongForDBId(id);

  //           String selectQuery = "SELECT A.* ";
  //           selectQuery += " FROM " + Tables.TABLE_OPPORTUNITYTYPE + " A ";
  //           selectQuery += " WHERE A." + Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPEID + " = " + id;
  //           selectQuery += " AND A." + Columns.KEY_OWNERUSERID + " = " + Globals.AppUserID;
  //           selectQuery += " AND A." + Columns.KEY_OPPORTUNITYTYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           Cursor cursor = db.rawQuery(selectQuery, null);
  //           if (cursor.moveToFirst()) {
  //               do {
  //                   dataItem = new OpportunityType();
  //                   dataItem.setOpportunityTypeID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPEID)));
  //                   dataItem.setOpportunityTypeCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPECODE)));
  //                   dataItem.setOpportunityTypeName(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME)));
  //                   dataItem.setInternalCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_INTERNALCODE)));
  //                   dataItem.setIsDefault(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISDEFAULT)));
  //                   dataItem.setSequentialOrder(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_SEQUENTIALORDER)));
  //                   dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_CREATEDON)));
  //                   dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_CREATEDBY)));
  //                   dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_MODIFIEDON)));
  //                   dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_MODIFIEDBY)));
  //                   dataItem.setUid(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_UID)));
  //                   dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_APPUSERID)));
  //                   dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_APPUSERGROUPID)));
  //                   dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISARCHIVED)));
  //                   dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISACTIVE)));
  //                   dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISDELETED)));


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
  //           Globals.HandleException(context, "OpportunityTypeDataHandlerBase:GetMasterOpportunityTypeRecord()", ex);
  //           throw ex;
  //       }
  //       return dataItem;
  //   }

  //   public static long AddOpportunityTypeRecord(DatabaseHandler databaseHandler, Context context, OpportunityType dataItem) {
  //       long id = 0;
  //       try {
  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           ContentValues values = new ContentValues();
  //           if (dataItem.getOpportunityTypeID() != null && !dataItem.getOpportunityTypeID().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPEID, dataItem.getOpportunityTypeID());
  //           if (dataItem.getOpportunityTypeCode() != null && !dataItem.getOpportunityTypeCode().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPECODE, dataItem.getOpportunityTypeCode());
  //           if (dataItem.getOpportunityTypeName() != null && !dataItem.getOpportunityTypeName().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME, dataItem.getOpportunityTypeName());
  //           if (dataItem.getInternalCode() != null && !dataItem.getInternalCode().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_INTERNALCODE, dataItem.getInternalCode());
  //           if (dataItem.getIsDefault() != null && !dataItem.getIsDefault().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_ISDEFAULT, dataItem.getIsDefault());
  //           if (dataItem.getSequentialOrder() != null && !dataItem.getSequentialOrder().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_SEQUENTIALORDER, dataItem.getSequentialOrder());
  //           if (dataItem.getCreatedOn() != null && !dataItem.getCreatedOn().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_CREATEDON, dataItem.getCreatedOn());
  //           if (dataItem.getCreatedBy() != null && !dataItem.getCreatedBy().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_CREATEDBY, dataItem.getCreatedBy());
  //           if (dataItem.getModifiedOn() != null && !dataItem.getModifiedOn().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_MODIFIEDON, dataItem.getModifiedOn());
  //           if (dataItem.getModifiedBy() != null && !dataItem.getModifiedBy().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_MODIFIEDBY, dataItem.getModifiedBy());
  //           if (dataItem.getUid() != null && !dataItem.getUid().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_UID, dataItem.getUid());
  //           if (dataItem.getAppUserID() != null && !dataItem.getAppUserID().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_APPUSERID, dataItem.getAppUserID());
  //           if (dataItem.getAppUserGroupID() != null && !dataItem.getAppUserGroupID().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_APPUSERGROUPID, dataItem.getAppUserGroupID());
  //           if (dataItem.getIsArchived() != null && !dataItem.getIsArchived().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_ISARCHIVED, dataItem.getIsArchived());
  //           if (dataItem.getIsActive() != null && !dataItem.getIsActive().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_ISACTIVE, dataItem.getIsActive());
  //           if (dataItem.getIsDeleted() != null && !dataItem.getIsDeleted().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_ISDELETED, dataItem.getIsDeleted());
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

  //           id = db.insert(Tables.TABLE_OPPORTUNITYTYPE, null, values);
  //           //db.close();
  //       } catch (Exception ex) {
  //           Globals.HandleException(context, "DatabaseHandler:AddOpportunityTypeRecord()", ex);
  //           throw ex;
  //       }
  //       return id;
  //   }

  //   public static long UpdateOpportunityTypeRecord(DatabaseHandler databaseHandler, Context context, String id1, OpportunityType dataItem) {
  //       long id = 0;
  //       try {
  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           ContentValues values = new ContentValues();
  //           if (dataItem.getOpportunityTypeID() != null && !dataItem.getOpportunityTypeID().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPEID, dataItem.getOpportunityTypeID());
  //           if (dataItem.getOpportunityTypeCode() != null && !dataItem.getOpportunityTypeCode().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPECODE, dataItem.getOpportunityTypeCode());
  //           if (dataItem.getOpportunityTypeName() != null && !dataItem.getOpportunityTypeName().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME, dataItem.getOpportunityTypeName());
  //           if (dataItem.getInternalCode() != null && !dataItem.getInternalCode().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_INTERNALCODE, dataItem.getInternalCode());
  //           if (dataItem.getIsDefault() != null && !dataItem.getIsDefault().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_ISDEFAULT, dataItem.getIsDefault());
  //           if (dataItem.getSequentialOrder() != null && !dataItem.getSequentialOrder().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_SEQUENTIALORDER, dataItem.getSequentialOrder());
  //           if (dataItem.getCreatedOn() != null && !dataItem.getCreatedOn().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_CREATEDON, dataItem.getCreatedOn());
  //           if (dataItem.getCreatedBy() != null && !dataItem.getCreatedBy().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_CREATEDBY, dataItem.getCreatedBy());
  //           if (dataItem.getModifiedOn() != null && !dataItem.getModifiedOn().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_MODIFIEDON, dataItem.getModifiedOn());
  //           if (dataItem.getModifiedBy() != null && !dataItem.getModifiedBy().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_MODIFIEDBY, dataItem.getModifiedBy());
  //           if (dataItem.getUid() != null && !dataItem.getUid().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_UID, dataItem.getUid());
  //           if (dataItem.getAppUserID() != null && !dataItem.getAppUserID().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_APPUSERID, dataItem.getAppUserID());
  //           if (dataItem.getAppUserGroupID() != null && !dataItem.getAppUserGroupID().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_APPUSERGROUPID, dataItem.getAppUserGroupID());
  //           if (dataItem.getIsArchived() != null && !dataItem.getIsArchived().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_ISARCHIVED, dataItem.getIsArchived());
  //           if (dataItem.getIsActive() != null && !dataItem.getIsActive().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_ISACTIVE, dataItem.getIsActive());
  //           if (dataItem.getIsDeleted() != null && !dataItem.getIsDeleted().equals("null"))
  //               values.put(Columns.KEY_OPPORTUNITYTYPE_ISDELETED, dataItem.getIsDeleted());
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

  //           id = db.update(Tables.TABLE_OPPORTUNITYTYPE, values, Columns.KEY_ID + " = " + id1, null);
  //           //db.close();
  //       } catch (Exception ex) {
  //           Globals.HandleException(context, "DatabaseHandler:UpdateOpportunityTypeRecord()", ex);
  //           throw ex;
  //       }
  //       return id;
  //   }

  //   public static long DeleteOpportunityTypeRecord(DatabaseHandler databaseHandler, Context context, String id1) {
  //       long id = 0;
  //       try {
  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           id = db.delete(Tables.TABLE_OPPORTUNITYTYPE, Columns.KEY_ID + " = " + id1, null);
  //           //db.close();
  //       } catch (Exception ex) {
  //           Globals.HandleException(context, "DatabaseHandler:DeleteOpportunityTypeRecord()", ex);
  //           throw ex;
  //       }
  //       return id;
  //   }

  //   public static String GetServerId(DatabaseHandler databaseHandler, Context context, String id) {
  //       String serverId = "-1";
  //       try {
  //           id = Globals.TryParseLongForDBId(id);

  //           String selectQuery = "SELECT A." + Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPEID;
  //           selectQuery += " FROM " + Tables.TABLE_OPPORTUNITYTYPE + " A ";
  //           selectQuery += " WHERE A." + Columns.KEY_ID + " = " + id;

  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           Cursor cursor = db.rawQuery(selectQuery, null);
  //           if (cursor.moveToFirst()) {
  //               serverId = cursor.getString(0);
  //           }
  //           cursor.close();
  //           //db.close();
  //       } catch (Exception ex) {
  //           Globals.HandleException(context, "OpportunityTypeDataHandlerBase:GetServerId()", ex);
  //           throw ex;
  //       }
  //       return serverId;
  //   }

  //   public static String GetLocalId(DatabaseHandler databaseHandler, Context context, String id) {
  //       String localId = "";
  //       try {

  //           id = Globals.TryParseLongForDBId(id);

  //           String selectQuery = "SELECT A." + Columns.KEY_ID;
  //           selectQuery += " FROM " + Tables.TABLE_OPPORTUNITYTYPE + " A ";
  //           selectQuery += " WHERE A." + Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPEID + " = " + id;

  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           Cursor cursor = db.rawQuery(selectQuery, null);
  //           if (cursor.moveToFirst()) {
  //               localId = cursor.getString(0);
  //           }
  //           cursor.close();
  //           //db.close();
  //       } catch (Exception ex) {
  //           Globals.HandleException(context, "OpportunityTypeDataHandlerBase:GetLocalId()", ex);
  //           throw ex;
  //       }
  //       return localId;
  //   }

  //   public static List<OpportunityType> GetOpportunityTypeUpSyncRecords(DatabaseHandler databaseHandler, Context context, String changeType) {
  //       List<OpportunityType> dataList = new ArrayList<OpportunityType>();
  //       try {
  //           String selectQuery = "SELECT * FROM " + Tables.TABLE_OPPORTUNITYTYPE + " WHERE " + Columns.KEY_ISDIRTY + " = 'true' AND " + Columns.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
  //           if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
  //               selectQuery = "SELECT * FROM " + Tables.TABLE_OPPORTUNITYTYPE + " WHERE " + Columns.KEY_ISDIRTY + " = 'true' AND " + Columns.KEY_ISDELETED + " = 'false' " + " AND " + Columns.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
  //           } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
  //               selectQuery = "SELECT * FROM " + Tables.TABLE_OPPORTUNITYTYPE + " WHERE " + Columns.KEY_ISDIRTY + " = 'true' AND " + Columns.KEY_ISDELETED + " = 'true' " + " AND " + Columns.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
  //           }
  //           selectQuery += " AND " + Columns.KEY_OWNERUSERID + " = " + Globals.AppUserID;
  //           selectQuery += " AND " + Columns.KEY_OPPORTUNITYTYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           Cursor cursor = db.rawQuery(selectQuery, null);
  //           if (cursor.moveToFirst()) {
  //               do {
  //                   OpportunityType dataItem = new OpportunityType();
  //                   dataItem.setOpportunityTypeID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPEID)));
  //                   dataItem.setOpportunityTypeCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPECODE)));
  //                   dataItem.setOpportunityTypeName(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME)));
  //                   dataItem.setInternalCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_INTERNALCODE)));
  //                   dataItem.setIsDefault(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISDEFAULT)));
  //                   dataItem.setSequentialOrder(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_SEQUENTIALORDER)));
  //                   dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_CREATEDON)));
  //                   dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_CREATEDBY)));
  //                   dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_MODIFIEDON)));
  //                   dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_MODIFIEDBY)));
  //                   dataItem.setUid(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_UID)));
  //                   dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_APPUSERID)));
  //                   dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_APPUSERGROUPID)));
  //                   dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISARCHIVED)));
  //                   dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISACTIVE)));
  //                   dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISDELETED)));

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
  //           Globals.HandleException(context, "OpportunityTypeDataHandlerBase:GetOpportunityTypeUpSyncRecords()", ex);
  //           throw ex;
  //       }
  //       return dataList;
  //   }


	//  public static OpportunityType GetOpportunityTypeRecordByUid(DatabaseHandler databaseHandler, Context context, String uid) {
  //       OpportunityType dataItem = null;
  //       try
  //       {

	// 		String selectQuery = 	"SELECT A.* " ;
	// 	selectQuery += " FROM " + Tables.TABLE_OPPORTUNITYTYPE + " A "; 
	// 		selectQuery += " WHERE A."  + Columns.KEY_OPPORTUNITYTYPE_UID + " = '" + uid + "'";
	// 		//selectQuery += " AND A." + Columns.KEY_OWNERUSERID + " = " + Globals.AppUserID;
	// 		//selectQuery += " AND A." + Columns.KEY_OPPORTUNITYTYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

  //           SQLiteDatabase db = databaseHandler.getWritableDatabase();
  //           Cursor cursor = db.rawQuery(selectQuery, null);
  //           if (cursor.moveToFirst()) {
  //               do {
  //                   dataItem = new OpportunityType();
	// 						dataItem.setOpportunityTypeID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPEID)));
	// 	dataItem.setOpportunityTypeCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPECODE)));
	// 	dataItem.setOpportunityTypeName(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME)));
	// 	dataItem.setInternalCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_INTERNALCODE)));
	// 	dataItem.setIsDefault(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISDEFAULT)));
	// 	dataItem.setSequentialOrder(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_SEQUENTIALORDER)));
	// 	dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_CREATEDON)));
	// 	dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_CREATEDBY)));
	// 	dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_MODIFIEDON)));
	// 	dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_MODIFIEDBY)));
	// 	dataItem.setUid(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_UID)));
	// 	dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_APPUSERID)));
	// 	dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_APPUSERGROUPID)));
	// 	dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISARCHIVED)));
	// 	dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISACTIVE)));
	// 	dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISDELETED)));


					
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
	//     Globals.HandleException(context, "OpportunityTypeDataHandlerBase:GetOpportunityTypeRecordByUid()", ex);
  //           throw ex;
  //       }
  //       return dataItem;
  //   }

	/*-------------------HAPPSALES-------------------*/

}