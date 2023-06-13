

 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ContactModels.dart/ContactMedia.dart';
import '../DataBaseHandler.dart';

class ContactMediaDataHandlerBase {

     static Future<List<ContactMedia>> GetContactMediaRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<ContactMedia> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_CONTACT_CONTACTNAME},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_CONTACTMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} D ON A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CONTACTMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACTMEDIA_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACTMEDIA_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACTMEDIA_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME} LIKE '%$searchString%'";
            }

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
				selectQuery += " AND A." + ColumnsBase.KEY_ContactMedia_Columns.KEY_CONTACTMEDIA_CONTACTMEDIANAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex}," + pageSize;

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var ele in result){
                   
                   
                    ContactMedia dataItem = new ContactMedia();

                    dataItem.contactMediaID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID];
                    dataItem.contactMediaCode = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIACODE];
                    dataItem.contactMediaName = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME];
                    dataItem.contactID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTID];
                    dataItem.contentTypeID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID];
                    dataItem.mediaPath = ele[ColumnsBase.KEY_CONTACTMEDIA_MEDIAPATH];
                    dataItem.mediaContent = ele[ColumnsBase.KEY_CONTACTMEDIA_MEDIACONTENT];
                    dataItem.description = ele[ColumnsBase.KEY_CONTACTMEDIA_DESCRIPTION];
                    dataItem.tags = ele[ColumnsBase.KEY_CONTACTMEDIA_TAGS];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_CONTACTMEDIA_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_CONTACTMEDIA_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_CONTACTMEDIA_ISARCHIVED];
                    dataItem.createdBy = ele[ColumnsBase.KEY_CONTACTMEDIA_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_CONTACTMEDIA_CREATEDON];

                    dataItem.contactName = ele[ColumnsBase.KEY_CONTACT_CONTACTNAME];
                    dataItem.contentTypeName = ele[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
                    dataList.add(dataItem);
                    dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage =
            ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage =
            ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn =
            ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser =
            ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser =
            ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID =
            ele[ColumnsBase.KEY_OWNERUSERID];

dataList.add(dataItem);
            }
          
        } catch ( ex) {
          //  Globals.HandleException(context, "ContactMediaDataHandlerBase:GetContactMediaRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<ContactMedia>> GetContactMediaRecords(DatabaseHandler databaseHandler,  String searchString) async {
        List<ContactMedia> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_CONTACT_CONTACTNAME},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_CONTACTMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} D ON A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CONTACTMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACTMEDIA_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACTMEDIA_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACTMEDIA_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME} LIKE '$searchString%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME} COLLATE NOCASE ASC ";

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var ele in result){
                   
                   
                    ContactMedia dataItem = new ContactMedia();

                    dataItem.contactMediaID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID];
                    dataItem.contactMediaCode = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIACODE];
                    dataItem.contactMediaName = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME];
                    dataItem.contactID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTID];
                    dataItem.contentTypeID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID];
                    dataItem.mediaPath = ele[ColumnsBase.KEY_CONTACTMEDIA_MEDIAPATH];
                    dataItem.mediaContent = ele[ColumnsBase.KEY_CONTACTMEDIA_MEDIACONTENT];
                    dataItem.description = ele[ColumnsBase.KEY_CONTACTMEDIA_DESCRIPTION];
                    dataItem.tags = ele[ColumnsBase.KEY_CONTACTMEDIA_TAGS];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_CONTACTMEDIA_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_CONTACTMEDIA_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_CONTACTMEDIA_ISARCHIVED];
                    dataItem.createdBy = ele[ColumnsBase.KEY_CONTACTMEDIA_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_CONTACTMEDIA_CREATEDON];

                    dataItem.contactName = ele[ColumnsBase.KEY_CONTACT_CONTACTNAME];
                    dataItem.contentTypeName = ele[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
                    dataList.add(dataItem);
                    dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage =
            ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage =
            ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn =
            ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser =
            ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser =
            ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID =
            ele[ColumnsBase.KEY_OWNERUSERID];

dataList.add(dataItem);
            }
        } catch ( ex) {
         //   Globals.HandleException(context, "ContactMediaDataHandlerBase:GetContactMediaRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<ContactMedia?> GetContactMediaRecord(DatabaseHandler databaseHandler,  String id) async{
        ContactMedia? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_CONTACT_CONTACTNAME},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_CONTACTMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} D ON A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CONTACTMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
  final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var ele in result){
                   
                   
                    ContactMedia dataItem = new ContactMedia();

                    dataItem.contactMediaID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID];
                    dataItem.contactMediaCode = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIACODE];
                    dataItem.contactMediaName = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME];
                    dataItem.contactID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTID];
                    dataItem.contentTypeID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID];
                    dataItem.mediaPath = ele[ColumnsBase.KEY_CONTACTMEDIA_MEDIAPATH];
                    dataItem.mediaContent = ele[ColumnsBase.KEY_CONTACTMEDIA_MEDIACONTENT];
                    dataItem.description = ele[ColumnsBase.KEY_CONTACTMEDIA_DESCRIPTION];
                    dataItem.tags = ele[ColumnsBase.KEY_CONTACTMEDIA_TAGS];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_CONTACTMEDIA_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_CONTACTMEDIA_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_CONTACTMEDIA_ISARCHIVED];
                    dataItem.createdBy = ele[ColumnsBase.KEY_CONTACTMEDIA_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_CONTACTMEDIA_CREATEDON];

                    dataItem.contactName = ele[ColumnsBase.KEY_CONTACT_CONTACTNAME];
                    dataItem.contentTypeName = ele[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
                    dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage =
            ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage =
            ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn =
            ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser =
            ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser =
            ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID =
            ele[ColumnsBase.KEY_OWNERUSERID];

            }
        } catch ( ex) {
          //  Globals.HandleException(context, "ContactMediaDataHandlerBase:GetContactMediaRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ContactMedia?> GetMasterContactMediaRecord(DatabaseHandler databaseHandler,  String id) async{
        ContactMedia? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_CONTACT_CONTACTNAME},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_CONTACTMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} D ON A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CONTACTMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            //db.close();
              final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var ele in result){
                   
                   
                    ContactMedia dataItem = new ContactMedia();

                    dataItem.contactMediaID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID];
                    dataItem.contactMediaCode = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIACODE];
                    dataItem.contactMediaName = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME];
                    dataItem.contactID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTID];
                    dataItem.contentTypeID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID];
                    dataItem.mediaPath = ele[ColumnsBase.KEY_CONTACTMEDIA_MEDIAPATH];
                    dataItem.mediaContent = ele[ColumnsBase.KEY_CONTACTMEDIA_MEDIACONTENT];
                    dataItem.description = ele[ColumnsBase.KEY_CONTACTMEDIA_DESCRIPTION];
                    dataItem.tags = ele[ColumnsBase.KEY_CONTACTMEDIA_TAGS];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_CONTACTMEDIA_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_CONTACTMEDIA_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_CONTACTMEDIA_ISARCHIVED];
                    dataItem.createdBy = ele[ColumnsBase.KEY_CONTACTMEDIA_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_CONTACTMEDIA_CREATEDON];

                    dataItem.contactName = ele[ColumnsBase.KEY_CONTACT_CONTACTNAME];
                    dataItem.contentTypeName = ele[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
                    dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage =
            ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage =
            ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn =
            ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser =
            ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser =
            ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID =
            ele[ColumnsBase.KEY_OWNERUSERID];

            }
        } catch ( ex) {
           // Globals.HandleException(context, "ContactMediaDataHandlerBase:GetMasterContactMediaRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static long AddContactMediaRecord(DatabaseHandler databaseHandler,  ContactMedia dataItem) {
        long id = 0;
        try {
            SQLiteDatabase db = databaseHandler.getWritableDatabase();
            ContentValues values = new ContentValues();
            if (dataItem.getContactMediaID() != null && !dataItem.getContactMediaID().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID, dataItem.getContactMediaID());
            }
            if (dataItem.getContactMediaCode() != null && !dataItem.getContactMediaCode().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIACODE, dataItem.getContactMediaCode());
            }
            if (dataItem.getContactMediaName() != null && !dataItem.getContactMediaName().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME, dataItem.getContactMediaName());
            }
            if (dataItem.getContactID() != null && !dataItem.getContactID().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_CONTACTID, dataItem.getContactID());
            }
            if (dataItem.getContentTypeID() != null && !dataItem.getContentTypeID().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID, dataItem.getContentTypeID());
            }
            if (dataItem.getMediaPath() != null && !dataItem.getMediaPath().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_MEDIAPATH, dataItem.getMediaPath());
            }
            if (dataItem.getMediaContent() != null && !dataItem.getMediaContent().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_MEDIACONTENT, dataItem.getMediaContent());
            }
            if (dataItem.getDescription() != null && !dataItem.getDescription().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_DESCRIPTION, dataItem.getDescription());
            }
            if (dataItem.getTags() != null && !dataItem.getTags().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_TAGS, dataItem.getTags());
            }
            if (dataItem.getLocalMediaPath() != null && !dataItem.getLocalMediaPath().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_LOCALMEDIAPATH, dataItem.getLocalMediaPath());
            }
            if (dataItem.getIsUploaded() != null && !dataItem.getIsUploaded().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_ISUPLOADED, dataItem.getIsUploaded());
            }
            if (dataItem.getCreatedBy() != null && !dataItem.getCreatedBy().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_CREATEDBY, dataItem.getCreatedBy());
            }
            if (dataItem.getCreatedOn() != null && !dataItem.getCreatedOn().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_CREATEDON, dataItem.getCreatedOn());
            }
            if (dataItem.getModifiedBy() != null && !dataItem.getModifiedBy().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_MODIFIEDBY, dataItem.getModifiedBy());
            }
            if (dataItem.getModifiedOn() != null && !dataItem.getModifiedOn().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_MODIFIEDON, dataItem.getModifiedOn());
            }
            if (dataItem.getDeviceIdentifier() != null && !dataItem.getDeviceIdentifier().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_DEVICEIDENTIFIER, dataItem.getDeviceIdentifier());
            }
            if (dataItem.getReferenceIdentifier() != null && !dataItem.getReferenceIdentifier().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_REFERENCEIDENTIFIER, dataItem.getReferenceIdentifier());
            }
            if (dataItem.getIsActive() != null && !dataItem.getIsActive().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_ISACTIVE, dataItem.getIsActive());
            }
            if (dataItem.getUid() != null && !dataItem.getUid().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_UID, dataItem.getUid());
            }
            if (dataItem.getAppUserID() != null && !dataItem.getAppUserID().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_APPUSERID, dataItem.getAppUserID());
            }
            if (dataItem.getAppUserGroupID() != null && !dataItem.getAppUserGroupID().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_APPUSERGROUPID, dataItem.getAppUserGroupID());
            }
            if (dataItem.getIsArchived() != null && !dataItem.getIsArchived().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_ISARCHIVED, dataItem.getIsArchived());
            }
            if (dataItem.getIsDeleted() != null && !dataItem.getIsDeleted().equals("null")) {
              values.put(ColumnsBase.KEY_CONTACTMEDIA_ISDELETED, dataItem.getIsDeleted());
            }
            if (dataItem.getId() != null && !dataItem.getId().equals("null")) {
              values.put(ColumnsBase.KEY_ID, dataItem.getId());
            }
            if (dataItem.getIsDirty() != null && !dataItem.getIsDirty().equals("null")) {
              values.put(ColumnsBase.KEY_ISDIRTY, dataItem.getIsDirty());
            }
            if (dataItem.getIsDeleted1() != null && !dataItem.getIsDeleted1().equals("null")) {
              values.put(ColumnsBase.KEY_ISDELETED, dataItem.getIsDeleted1());
            }
            if (dataItem.getUpSyncMessage() != null && !dataItem.getUpSyncMessage().equals("null")) {
              values.put(ColumnsBase.KEY_UPSYNCMESSAGE, dataItem.getUpSyncMessage());
            }
            if (dataItem.getDownSyncMessage() != null && !dataItem.getDownSyncMessage().equals("null")) {
              values.put(ColumnsBase.KEY_DOWNSYNCMESSAGE, dataItem.getDownSyncMessage());
            }
            if (dataItem.getSCreatedOn() != null && !dataItem.getSCreatedOn().equals("null")) {
              values.put(ColumnsBase.KEY_SCREATEDON, dataItem.getSCreatedOn());
            }
            if (dataItem.getSModifiedOn() != null && !dataItem.getSModifiedOn().equals("null")) {
              values.put(ColumnsBase.KEY_SMODIFIEDON, dataItem.getSModifiedOn());
            }
            if (dataItem.getCreatedByUser() != null && !dataItem.getCreatedByUser().equals("null")) {
              values.put(ColumnsBase.KEY_CREATEDBYUSER, dataItem.getCreatedByUser());
            }
            if (dataItem.getModifiedByUser() != null && !dataItem.getModifiedByUser().equals("null")) {
              values.put(ColumnsBase.KEY_MODIFIEDBYUSER, dataItem.getModifiedByUser());
            }
            if (dataItem.getOwnerUserID() != null && !dataItem.getOwnerUserID().equals("null")) {
              values.put(ColumnsBase.KEY_OWNERUSERID, dataItem.getOwnerUserID());
            }
            values.put(ColumnsBase.KEY_UPSYNCINDEX, 0);
            values.put(ColumnsBase.KEY_ISACTIVE, "true");
            values.put(ColumnsBase.KEY_ISDELETED, "false");

            id = db.insert(TablesBase.TABLE_CONTACTMEDIA, null, values);
            //db.close();
        } catch (Exception ex) {
            Globals.HandleException(context, "DatabaseHandler:AddContactMediaRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateContactMediaRecord(DatabaseHandler databaseHandler,  String id1, ContactMedia dataItem) async {
        int id = 0;
        try {

          final db = databaseHandler.database;
          
          
          
                   Map<String, dynamic> values = {};

if (dataItem.contactMediaID != null && dataItem.contactMediaID != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID] = dataItem.contactMediaID;
}
if (dataItem.contactMediaCode != null && dataItem.contactMediaCode != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIACODE] = dataItem.contactMediaCode;
}
if (dataItem.contactMediaName != null && dataItem.contactMediaName != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME] = dataItem.contactMediaName;
}
if (dataItem.contactID != null && dataItem.contactID != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_CONTACTID] = dataItem.contactID;
}
if (dataItem.contentTypeID != null && dataItem.contentTypeID != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID] = dataItem.contentTypeID;
}
if (dataItem.mediaPath != null && dataItem.mediaPath != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_MEDIAPATH] = dataItem.mediaPath;
}
if (dataItem.mediaContent != null && dataItem.mediaContent != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_MEDIACONTENT] = dataItem.mediaContent;
}
if (dataItem.description != null && dataItem.description != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_DESCRIPTION] = dataItem.description;
}
if (dataItem.tags != null && dataItem.tags != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_TAGS] = dataItem.tags;
}
if (dataItem.localMediaPath != null && dataItem.localMediaPath != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_LOCALMEDIAPATH] = dataItem.localMediaPath;
}
if (dataItem.isUploaded != null && dataItem.isUploaded != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_ISUPLOADED] = dataItem.isUploaded;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_APPUSERID] = dataItem.appUserID;
}
  if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
    values[ColumnsBase.KEY_CONTACTMEDIA_APPUSERGROUPID] = dataItem.appUserGroupID;
  }
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_CONTACTMEDIA_ISDELETED] = dataItem.isDeleted;
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

  //db.close();
        } catch ( ex) {
          //  Globals.HandleException(context, "DatabaseHandler:UpdateContactMediaRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteContactMediaRecord(DatabaseHandler databaseHandler,  String id1)async {
        int id = 0;
        try {
          final db = await databaseHandler.database;
          
                      id = await db.delete(TablesBase.TABLE_CONTACTMEDIA, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
         //   Globals.HandleException(context, "DatabaseHandler:DeleteContactMediaRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID}";
            selectQuery += " FROM ${TablesBase.TABLE_CONTACTMEDIA} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

          final db = await databaseHandler.database;

          List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result != null && result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID];
            }
            //db.close();
           
        } catch ( ex) {
           // Globals.HandleException(context, "ContactMediaDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_CONTACTMEDIA} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID} = $id";
final db = await databaseHandler.database;

          List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result != null && result.length > 0) {
                localId = result[0][ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID];
            }
        } catch ( ex) {
           // Globals.HandleException(context, "ContactMediaDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static List<ContactMedia> GetContactMediaUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) {
        List<ContactMedia> dataList = new ArrayList<ContactMedia>();
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_CONTACTMEDIA} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex;
            /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_CONTACTMEDIA + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_CONTACTMEDIA + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID;
            selectQuery += " AND ${ColumnsBase.KEY_CONTACTMEDIA_APPUSERGROUPID} = " + Globals.AppUserGroupID;
            selectQuery += " AND ${ColumnsBase.KEY_CONTACTMEDIA_CONTACTID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_CONTACT} WHERE CAST(COALESCE(${ColumnsBase.KEY_CONTACT_CONTACTID},'0') AS long) > 0)";

            SQLiteDatabase db = databaseHandler.getWritableDatabase();
            Cursor cursor = db.rawQuery(selectQuery, null);
            if (cursor.moveToFirst()) {
                do {
                    ContactMedia dataItem = new ContactMedia();
                    dataItem.setContactMediaID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID)));
                    dataItem.setContactMediaCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIACODE)));
                    dataItem.setContactMediaName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME)));
                    dataItem.setContactID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_CONTACTID)));
                    dataItem.setContentTypeID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID)));
                    dataItem.setMediaPath(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_MEDIAPATH)));
                    dataItem.setMediaContent(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_MEDIACONTENT)));
                    dataItem.setDescription(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_DESCRIPTION)));
                    dataItem.setTags(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_TAGS)));
                    dataItem.setLocalMediaPath(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_LOCALMEDIAPATH)));
                    dataItem.setIsUploaded(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_ISUPLOADED)));
                    dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_CREATEDBY)));
                    dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_CREATEDON)));
                    dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_MODIFIEDBY)));
                    dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_MODIFIEDON)));
                    dataItem.setDeviceIdentifier(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_DEVICEIDENTIFIER)));
                    dataItem.setReferenceIdentifier(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_REFERENCEIDENTIFIER)));
                    dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_ISACTIVE)));
                    dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_UID)));
                    dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_APPUSERID)));
                    dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_APPUSERGROUPID)));
                    dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_ISARCHIVED)));
                    dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_ISDELETED)));

                    dataItem.setId(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ID)));
                    dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDIRTY)));
                    dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDELETED)));
                    dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_UPSYNCMESSAGE)));
                    dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_DOWNSYNCMESSAGE)));
                    dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SCREATEDON)));
                    dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SMODIFIEDON)));
                    dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CREATEDBYUSER)));
                    dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_MODIFIEDBYUSER)));
                    dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OWNERUSERID)));

                    dataList.add(dataItem);
                } while (cursor.moveToNext());
            }
            cursor.close();
            //db.close();
        } catch (Exception ex) {
            Globals.HandleException(context, "ContactMediaDataHandlerBase:GetContactMediaUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static ContactMedia GetContactMediaRecordByUid(DatabaseHandler databaseHandler,  String uid) {
        ContactMedia dataItem = null;
        try
        {

			String selectQuery = 	"SELECT A.* ,D.${ColumnsBase.KEY_CONTACT_CONTACTNAME},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
		selectQuery += " FROM ${TablesBase.TABLE_CONTACTMEDIA} A "; 
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} D ON A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTID} = D.${ColumnsBase.KEY_ID}";
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_CONTACTMEDIA_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			//selectQuery += " AND A." + ColumnsBase.KEY_CONTACTMEDIA_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

            SQLiteDatabase db = databaseHandler.getWritableDatabase();
            Cursor cursor = db.rawQuery(selectQuery, null);
            if (cursor.moveToFirst()) {
                do {
                    dataItem = new ContactMedia();
							dataItem.setContactMediaID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID)));
		dataItem.setContactMediaCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIACODE)));
		dataItem.setContactMediaName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME)));
		dataItem.setContactID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_CONTACTID)));
		dataItem.setContentTypeID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID)));
		dataItem.setMediaPath(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_MEDIAPATH)));
		dataItem.setMediaContent(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_MEDIACONTENT)));
		dataItem.setDescription(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_DESCRIPTION)));
		dataItem.setTags(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_TAGS)));
		dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_CREATEDBY)));
		dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_CREATEDON)));
		dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_MODIFIEDBY)));
		dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_MODIFIEDON)));
		dataItem.setDeviceIdentifier(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_DEVICEIDENTIFIER)));
		dataItem.setReferenceIdentifier(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_REFERENCEIDENTIFIER)));
		dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_ISACTIVE)));
		dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_UID)));
		dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_APPUSERID)));
		dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_APPUSERGROUPID)));
		dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_ISARCHIVED)));
		dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACTMEDIA_ISDELETED)));

		dataItem.setContactName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTACT_CONTACTNAME)));
		dataItem.setContentTypeName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME)));

					
					dataItem.setId(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ID)));
					dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDIRTY)));
					dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDELETED)));
					dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_UPSYNCMESSAGE)));				
					dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_DOWNSYNCMESSAGE)));
					dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SCREATEDON)));
					dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SMODIFIEDON)));
					dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CREATEDBYUSER)));
					dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_MODIFIEDBYUSER)));
					dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OWNERUSERID)));
					
				} while (cursor.moveToNext());
            }
            cursor.close();
            //db.close();
        }
        catch(Exception ex)
        {
	    Globals.HandleException(context, "ContactMediaDataHandlerBase:GetContactMediaRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}